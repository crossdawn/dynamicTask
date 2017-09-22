package com.dynamic.task.quartz;

import org.quartz.*;
import org.quartz.Trigger.TriggerState;
import org.quartz.impl.matchers.GroupMatcher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;

import java.util.*;
/**
 * Created by zhangrui on 2017-09-22.
 */
public final class DynamicSchedulerUtil implements InitializingBean {
    private static final Logger logger = LoggerFactory.getLogger(DynamicSchedulerUtil.class);

    // Scheduler
    private static Scheduler scheduler;
    public static void setScheduler(Scheduler scheduler) {
		DynamicSchedulerUtil.scheduler = scheduler;
	}

	@Override
    public void afterPropertiesSet() throws Exception {
        Assert.notNull(scheduler, "task scheduler is null");
        logger.info(">>>>>>>>> init task scheduler success.[{}]", scheduler);
    }
	
	// getJobKeys
	public static List<Map<String, Object>> getJobList(){
		List<Map<String, Object>> jobList = new ArrayList<Map<String,Object>>();
		
		try {
			if (scheduler.getJobGroupNames()==null || scheduler.getJobGroupNames().size()==0) {
				return null;
			}
			String groupName = scheduler.getJobGroupNames().get(0);
			Set<JobKey> jobKeys = scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName));
			if (jobKeys!=null && jobKeys.size()>0) {
				for (JobKey jobKey : jobKeys) {
			        TriggerKey triggerKey = TriggerKey.triggerKey(jobKey.getName(), Scheduler.DEFAULT_GROUP);
			        Trigger trigger = scheduler.getTrigger(triggerKey);
			        JobDetail jobDetail = scheduler.getJobDetail(jobKey);
			        TriggerState triggerState = scheduler.getTriggerState(triggerKey);
			        Map<String, Object> jobMap = new HashMap<String, Object>();
			        jobMap.put("TriggerKey", triggerKey);
			        jobMap.put("Trigger", trigger);
			        jobMap.put("JobDetail", jobDetail);
			        jobMap.put("TriggerState", triggerState);
			        jobList.add(jobMap);
				}
			}
			
		} catch (SchedulerException e) {
			e.printStackTrace();
			return null;
		}
		return jobList;
	}

	public static final String job_desc = "job_desc";
	// addJob 新增
    public static boolean addJob(String triggerKeyName, String cronExpression, Class<? extends Job> jobClass, Map<String, Object> jobData) throws SchedulerException {
    	// TriggerKey : name + group
    	String group = Scheduler.DEFAULT_GROUP;
        TriggerKey triggerKey = TriggerKey.triggerKey(triggerKeyName, group);
        
        // TriggerKey valid if_exists
        if (scheduler.checkExists(triggerKey)) {
            Trigger trigger = scheduler.getTrigger(triggerKey);
            logger.info(">>>>>>>>> Already exist trigger [" + trigger + "] by key [" + triggerKey + "] in Scheduler");
            return false;
        }
        
        // CronTrigger : TriggerKey + cronExpression
        CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression).inTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
        CronTrigger cronTrigger = TriggerBuilder.newTrigger().withIdentity(triggerKey).withSchedule(cronScheduleBuilder).build();

        // JobDetail : jobClass
        JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(triggerKeyName, group).build();
        if (jobData!=null && jobData.size() > 0) {
        	JobDataMap jobDataMap = jobDetail.getJobDataMap();
        	jobDataMap.putAll(jobData);	// JobExecutionContext context.getMergedJobDataMap().get("mailGuid");
		}
        
        // schedule : jobDetail + cronTrigger
        Date date = scheduler.scheduleJob(jobDetail, cronTrigger);

        logger.info(">>>>>>>>>>> addJob success, jobDetail:{}, cronTrigger:{}, date:{}", jobDetail, cronTrigger, date);
        return true;
    }
    
    // reschedule 重置cron
    public static boolean rescheduleJob(String triggerKeyName, String cronExpression) throws SchedulerException {
        // TriggerKey : name + group
    	String group = Scheduler.DEFAULT_GROUP;
        TriggerKey triggerKey = TriggerKey.triggerKey(triggerKeyName, group);
        
        boolean result = false;
        if (scheduler.checkExists(triggerKey)) {
            // CronTrigger : TriggerKey + cronExpression
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression).inTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
            CronTrigger cronTrigger = TriggerBuilder.newTrigger().withIdentity(triggerKey).withSchedule(cronScheduleBuilder).build();
            
            Date date = scheduler.rescheduleJob(triggerKey, cronTrigger);
            result = true;
            logger.info(">>>>>>>>>>> resumeJob success, triggerKey:{}, cronExpression:{}, date:{}", triggerKey, cronExpression, date);
        } else {
        	logger.info(">>>>>>>>>>> resumeJob fail, triggerKey:{}, cronExpression:{}", triggerKey, cronExpression);
        }
        return result;
    }
    
    // unscheduleJob 删除
    public static boolean removeJob(String triggerKeyName) throws SchedulerException {
    	// TriggerKey : name + group
    	String group = Scheduler.DEFAULT_GROUP;
        TriggerKey triggerKey = TriggerKey.triggerKey(triggerKeyName, group);
        
        boolean result = false;
        if (scheduler.checkExists(triggerKey)) {
            result = scheduler.unscheduleJob(triggerKey);
        }
        logger.info(">>>>>>>>>>> removeJob, triggerKey:{}, result [{}]", triggerKey, result);
        return result;
    }

    // Pause 暂停
    public static boolean pauseJob(String triggerKeyName) throws SchedulerException {
    	// TriggerKey : name + group
    	String group = Scheduler.DEFAULT_GROUP;
        TriggerKey triggerKey = TriggerKey.triggerKey(triggerKeyName, group);
        
        boolean result = false;
        if (scheduler.checkExists(triggerKey)) {
            scheduler.pauseTrigger(triggerKey);
            result = true;
            logger.info(">>>>>>>>>>> pauseJob success, triggerKey:{}", triggerKey);
        } else {
        	logger.info(">>>>>>>>>>> pauseJob fail, triggerKey:{}", triggerKey);
        }
        return result;
    }
    
    // resume 重启 
    public static boolean resumeJob(String triggerKeyName) throws SchedulerException {
        // TriggerKey : name + group
    	String group = Scheduler.DEFAULT_GROUP;
        TriggerKey triggerKey = TriggerKey.triggerKey(triggerKeyName, group);
        
        boolean result = false;
        if (scheduler.checkExists(triggerKey)) {
            scheduler.resumeTrigger(triggerKey);
            result = true;
            logger.info(">>>>>>>>>>> resumeJob success, triggerKey:{}", triggerKey);
        } else {
        	logger.info(">>>>>>>>>>> resumeJob fail, triggerKey:{}", triggerKey);
        }
        return result;
    }

}