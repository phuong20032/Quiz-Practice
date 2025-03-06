/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.security.MessageDigest;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author Admin using SHA-1 algorithms to encode password
 */
public class EncodePassword {

    public static String toSHAI(String str) {

        String salt = "27jf77fbsf6723dfda213dsfsdf675";
        String result = null;

        str = str + salt;

        try {
            byte[] dataByte = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            result = Base64.encodeBase64String(md.digest(dataByte));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String decode(String hashedStr) {
        String decodedStr = null;
        try {
            byte[] decodedBytes = Base64.decodeBase64(hashedStr);
            decodedStr = new String(decodedBytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return decodedStr;
    }

    public static void main(String[] args) {
        System.out.println(toSHAI("123456"));
    }
}
