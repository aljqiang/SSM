package com.ssm.framework.interceptors;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.dao.DataAccessException;

import java.io.IOException;
import java.sql.SQLException;

/**
 * User: Larry
 * Date: 2015-10-21
 * Time: 9:23
 * Version: 1.0
 */

public class LogInterceptor {
    private static Logger log = Logger.getLogger(LogInterceptor.class);

    private String msg = null;  // 日志信息

    /**
     * 前置通知：在某连接点之前执行的通知，但这个通知不能阻止连接点前的执行
     */
    public void doBefore(JoinPoint jp) {
        msg = jp.getTarget().getClass().getName() + " 类的 "
                + jp.getSignature().getName() + " 方法开始执行 ***Start***";
        log.info(msg);
    }

    /**
     * 环绕通知：包围一个连接点的通知，可以在方法的调用前后完成自定义的行为，也可以选择不执行
     */
    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {

        Object result = null;
        try {
            result = pjp.proceed();
        } catch (Exception ex) {
            msg = "方法：" + pjp.getTarget().getClass() + "." + pjp.getSignature().getName() + "()  ";

            String eMsg = null;
            if (ex.getClass().equals(DataAccessException.class)) {
                eMsg = "数据库操作失败！";
            } else if (ex.getClass().toString().equals(NullPointerException.class.toString())) {
                eMsg = "调用了未经初始化的对象或者是不存在的对象！";
            } else if (ex.getClass().equals(IOException.class)) {
                eMsg = "IO异！";
            } else if (ex.getClass().equals(ClassNotFoundException.class)) {
                eMsg = "指定的类不存在！";
            } else if (ex.getClass().equals(ArithmeticException.class)) {
                eMsg = "数学运算异常！";
            } else if (ex.getClass().equals(ArrayIndexOutOfBoundsException.class)) {
                eMsg = "数组下标越界!";
            } else if (ex.getClass().equals(IllegalArgumentException.class)) {
                eMsg = "方法的参数错误！";
            } else if (ex.getClass().equals(ClassCastException.class)) {
                eMsg = "类型强制转换错误！";
            } else if (ex.getClass().equals(SecurityException.class)) {
                eMsg = "违背安全原则异常！";
            } else if (ex.getClass().equals(SQLException.class)) {
                eMsg = "操作数据库异常！";
            } else if (ex.getClass().equals(NoSuchMethodError.class)) {
                eMsg = "方法末找到异常！";
            } else if (ex.getClass().equals(InternalError.class)) {
                eMsg = "Java虚拟机发生了内部错误";
            } else {
                eMsg = "程序内部错误，操作失败！" + ex.getMessage();
            }
            msg = msg + "错误信息：[" + eMsg + "]";
            log.warn(msg, ex);
        }

        return result;
    }


    /**
     * 后置通知
     */
    public void doAfter(JoinPoint jp) {
        msg = jp.getTarget().getClass().getName() + " 类的 "
                + jp.getSignature().getName() + " 方法执行结束 ***End***";
        log.info(msg);
    }
}
