package com.dynamic.task.service.impl;

import com.dynamic.task.dao.QuartzJobInfoDao;
import com.dynamic.task.model.QuartzJobInfo;
import com.dynamic.task.service.QuartzJobInfoService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangrui on 2017-09-22.
 */
@Service("qrtzJobInfoService")
public class QuartzJobInfoServiceImpl implements QuartzJobInfoService {

    @Autowired
    private QuartzJobInfoDao quartzJobInfoDao;

    @Override
    public boolean checkJobRun(String jobName) {
        if (StringUtils.isEmpty(jobName)) {
            return false;
        }
        QuartzJobInfo quartzJobInfo = quartzJobInfoDao.selectQuartzInfo(jobName);
        return null == quartzJobInfo;
    }
}