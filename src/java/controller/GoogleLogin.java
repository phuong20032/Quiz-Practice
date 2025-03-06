/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import controller.constant.CommonConst;
import model.GoogleAccount;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author ADMIN
 */
public class GoogleLogin {

    private GoogleLogin() {
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {

        String response = Request.Post(CommonConst.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", CommonConst.GOOGLE_CLIENT_ID)
                                .add("client_secret", CommonConst.GOOGLE_CLIENT_SECRET)
                                .add("redirect_uri", CommonConst.GOOGLE_REDIRECT_URI)
                                .add("code", code)
                                .add("grant_type", CommonConst.GOOGLE_GRANT_TYPE)
                                .build()
                )
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").toString().replaceAll("\"", "");
    }

    public static GoogleAccount getUserInfo(final String accessToken) throws ClientProtocolException, IOException {

        String link = CommonConst.GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();

        return new Gson().fromJson(response, GoogleAccount.class);

    }
}
