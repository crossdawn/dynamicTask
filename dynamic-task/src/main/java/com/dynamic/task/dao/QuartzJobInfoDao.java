package com.dynamic.task.dao;

import com.dynamic.task.model.QuartzJobInfo;

/**
 * Created by zhangrui on 2017-09-22.
 */
public interface QuartzJobInfoDao {
     QuartzJobInfo selectQuartzInfo(String jobName);
}