package com.dynamic.task.controller;


import com.dynamic.task.quartz.DynamicSchedulerUtil;
import com.dynamic.task.quartz.ReturnT;
import com.dynamic.task.service.QuartzJobInfoService;
import org.apache.commons.lang.StringUtils;
import org.quartz.CronExpression;
import org.quartz.Job;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * Created by zhangrui on 2017-09-22.
 */
@Controller
@RequestMapping("/job")
public class IndexController {
	@Autowired
	private QuartzJobInfoService qrtzJobInfoService;

	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	@RequestMapping("/index")
	public String index(Model model) {
		List<Map<String, Object>> jobList = DynamicSchedulerUtil.getJobList();
		model.addAttribute("jobList", jobList);
		return "job/index";
	}

	@RequestMapping("/add")
	@ResponseBody
	public ReturnT<String> add(String triggerKeyName, String cronExpression, String jobClassName, String jobDesc) {
		// triggerKeyName
		if (StringUtils.isBlank(triggerKeyName)) {
			return new ReturnT<String>(500, "请输入“任务key”");
		}
		// cronExpressions
		if (StringUtils.isBlank(cronExpression)) {
			return new ReturnT<String>(500, "请输入“任务corn”");
		}
		if (!CronExpression.isValidExpression(cronExpression)) {
			return new ReturnT<String>(500, "“任务corn”不合法");
		}
		// jobClassName
		Class<?> clazz = null;
		try {
			clazz = Class.forName(jobClassName);
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		if (clazz == null) {
			return new ReturnT<String>(500, "“任务Impl”不合法");
		}
		if (!Job.class.isAssignableFrom(clazz)) {
			return new ReturnT<String>(500, "“任务Impl”类必须继承Job接口");
		}
		@SuppressWarnings("unchecked")
		Class<? extends Job> jobClass = (Class<? extends Job>)clazz;
		// jobDesc
		if (StringUtils.isBlank(jobDesc)) {
			return new ReturnT<String>(500, "请输入“任务描述”");
		}
		try {
			Map<String, Object> jobData = new HashMap<String, Object>();
			jobData.put(DynamicSchedulerUtil.job_desc, jobDesc);
			DynamicSchedulerUtil.addJob(triggerKeyName, cronExpression, jobClass, jobData);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
		} 
		return ReturnT.FAIL;
	}
	
	@RequestMapping("/reschedule")
	@ResponseBody
	public ReturnT<String> reschedule(String triggerKeyName, String cronExpression) {
		// triggerKeyName
		if (StringUtils.isBlank(triggerKeyName)) {
			return new ReturnT<String>(500, "请输入“任务key”");
		}
		// cronExpression
		if (StringUtils.isBlank(cronExpression)) {
			return new ReturnT<String>(500, "请输入“任务corn”");
		}
		if (!CronExpression.isValidExpression(cronExpression)) {
			return new ReturnT<String>(500, "“任务corn”不合法");
		}

		boolean is = qrtzJobInfoService.checkJobRun(triggerKeyName);
		if(is){
			return new ReturnT<String>(500, "当前任务正在进行中。”");
		}

		try {
			DynamicSchedulerUtil.rescheduleJob(triggerKeyName, cronExpression);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
	}
		return ReturnT.FAIL;
	}

	@RequestMapping("/runNow")
	@ResponseBody
	public ReturnT<String> runNow(String triggerKeyName) {

		boolean is = qrtzJobInfoService.checkJobRun(triggerKeyName);

		if(is){
			return new ReturnT<String>(500, "running");
		}


		try {
			DynamicSchedulerUtil.resumeJob(triggerKeyName);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return ReturnT.FAIL;
	}


	@RequestMapping("/remove")
	@ResponseBody
	public ReturnT<String> remove(String triggerKeyName) {
		try {
			DynamicSchedulerUtil.removeJob(triggerKeyName);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return ReturnT.FAIL;
		}
	}
	
	@RequestMapping("/pause")
	@ResponseBody
	public ReturnT<String> pause(String triggerKeyName) {
		try {
			DynamicSchedulerUtil.pauseJob(triggerKeyName);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return ReturnT.FAIL;
		}
	}
	
	@RequestMapping("/resume")
	 @ResponseBody
	 public ReturnT<String> resume(String triggerKeyName) {
		try {
			DynamicSchedulerUtil.resumeJob(triggerKeyName);
			return ReturnT.SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return ReturnT.FAIL;
		}
	}

	@RequestMapping("/help")
	public String help(Model model) {
		return "job/help";
	}

}