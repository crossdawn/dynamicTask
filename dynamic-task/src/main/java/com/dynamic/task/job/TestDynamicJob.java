package com.dynamic.task.job;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

/**
 * Created by zhangrui on 2017-09-22.
 */
public class TestDynamicJob implements Job {

	private static Logger logger = LoggerFactory.getLogger(TestDynamicJob.class);

	@Override
	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		test();
	}
	public void test(){
		System.out.println("本次定时任务执行》》》》》》》》》》》》"+ new Date(System.currentTimeMillis()));
	}
}