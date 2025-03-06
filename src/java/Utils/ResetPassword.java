/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import model.AccountDTO;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ResetPassword {

    public String getRandom() {
        Random rd = new Random();
        int number = rd.nextInt(99999);
        return String.format("%06d", number);
    }

    public boolean checkEmailReset(AccountDTO rd) {
        boolean test = false;
        final String from = "quizpractice.swp@gmail.com";
        final String password = "eblv ejlk wkvk jxij";

        // Properties : Declare all Attribute:
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, password);
            }
        };

        //Work Session:
        Session session = Session.getInstance(props, auth);

        // Sent email for user:
        final String to = rd.getEmail();
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            //Sender email:
            msg.setFrom(from);

            //Receiver email:
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(rd.getEmail(), false));

            //Title Email:
            msg.setSubject("Reset Your Password");

            //Set date which you want to sent to user:
            msg.setSentDate(new Date());

 
            msg.setText("Verified Code: " + rd.getCode(), "UTF-8");
            //Sent Email to User:
            Transport.send(msg);

            test = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }
}
