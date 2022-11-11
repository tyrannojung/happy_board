package com.happymoney.test.common.mail.service;

import com.happymoney.test.common.mail.dto.EmailDTO;

public interface MailService {

    public void sendToHtml(String from, String to, String title, String content) throws Exception;

    public void sendToHtml(EmailDTO email) throws Exception;

    public boolean sendTestMail(EmailDTO email) throws Exception;

    public void sendToHtml(String from, String[] to, String title, String content) throws Exception;

    public void sendToHtml(EmailDTO email, String[] to) throws Exception;

}