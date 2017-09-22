package com.dynamic.task.service;
/**
 * Created by zhangrui on 2017-09-22.
 */
public interface QuartzJobInfoService {
    /**
     * 新增当前任务是否正在进行。避免重复进行。
     *
     * @param jobName
     * @return true 当前任务正在进行
     * false 当前任务未进行
     */
    boolean checkJobRun(String jobName);
}