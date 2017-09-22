package com.dynamic.task.model;

/**
 * Created by zhangrui on 2017-09-22.
 */
public class QuartzJobInfo {
    private Long id;
    private String sched_name;
    private String entry_id;
    private String trigger_name;
    private String trigger_group;
    private String instance_name;
    private String fired_time;
    private String sched_time;
    private String priority;
    private String state;
    private String job_name;
    private String job_group;
    private String is_nonconcurrent;
    private String requests_recovery;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSched_name() {
        return sched_name;
    }

    public void setSched_name(String sched_name) {
        this.sched_name = sched_name;
    }

    public String getEntry_id() {
        return entry_id;
    }

    public void setEntry_id(String entry_id) {
        this.entry_id = entry_id;
    }

    public String getTrigger_name() {
        return trigger_name;
    }

    public void setTrigger_name(String trigger_name) {
        this.trigger_name = trigger_name;
    }

    public String getTrigger_group() {
        return trigger_group;
    }

    public void setTrigger_group(String trigger_group) {
        this.trigger_group = trigger_group;
    }

    public String getInstance_name() {
        return instance_name;
    }

    public void setInstance_name(String instance_name) {
        this.instance_name = instance_name;
    }

    public String getFired_time() {
        return fired_time;
    }

    public void setFired_time(String fired_time) {
        this.fired_time = fired_time;
    }

    public String getSched_time() {
        return sched_time;
    }

    public void setSched_time(String sched_time) {
        this.sched_time = sched_time;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getJob_name() {
        return job_name;
    }

    public void setJob_name(String job_name) {
        this.job_name = job_name;
    }

    public String getJob_group() {
        return job_group;
    }

    public void setJob_group(String job_group) {
        this.job_group = job_group;
    }

    public String getIs_nonconcurrent() {
        return is_nonconcurrent;
    }

    public void setIs_nonconcurrent(String is_nonconcurrent) {
        this.is_nonconcurrent = is_nonconcurrent;
    }

    public String getRequests_recovery() {
        return requests_recovery;
    }

    public void setRequests_recovery(String requests_recovery) {
        this.requests_recovery = requests_recovery;
    }
}
