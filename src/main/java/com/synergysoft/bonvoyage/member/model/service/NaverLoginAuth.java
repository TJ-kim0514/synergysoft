package com.synergysoft.bonvoyage.member.model.service;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component("naverLoginAuth")
public class NaverLoginAuth {
	private final static Logger logger = LoggerFactory.getLogger(NaverLoginAuth.class);

	private final static String CLIENT_ID = "GcBRifOkv0F3VVJTZbQd";
	private final static String CLIENT_SECRET = "oQGA50g1qL";
	private final static String REDIRECT_URI = "http://localhost:8080/bonvoyage/naverLogin.do";
	private final static String SESSION_STATE = "oauth_state";

	// 프로필 조회 API URL
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";

	/* 세션 유효성 검증을 위한 난수 생성기 */
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	/* http session에 데이터 저장 */
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	/* http session에서 데이터 가져오기 */
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}

	// 네이버 아이디로 인증 URL 생성 Method
	public String getAuthorizationUrl(HttpSession session) {
		// 세션 유효성 검증을 위해 난수 생성
		String state = generateRandomString();
		// 생성한 난수 값을 session에 저장
		setSession(session, state);

		/* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());

		logger.info("Generated naver URL: {}", oauthService.getAuthorizationUrl());
		return oauthService.getAuthorizationUrl();
	}

	/* 네이버아이디로 Callback 처리 및 AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
		logger.info("NaverLoginAuth.getAccessToken 접근");

		// 세션 상태 검증
		String sessionState = getSession(session);
		logger.info("Session state: {}, Received state: {}", sessionState, state);

		if (sessionState != null && sessionState.equals(state)) {
			try {
				OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
						.callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());

				// Access Token 획득
				OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
				logger.info("Access token obtained: {}", accessToken.getAccessToken());
				return accessToken;
			} catch (Exception e) {
				logger.error("Error while getting access token: ", e);
				return null;
			}
		}
		logger.warn("Invalid session state. Session state: {}, Received state: {}", sessionState, state);
		return null;
	}

	/* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException {
		logger.info("NaverLoginAuth.getUserProfile 접근");

		try {
			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI).build(NaverLoginApi.instance());

			OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
			oauthService.signRequest(oauthToken, request);
			Response response = request.send();
			logger.info("Response body: {}", response.getBody());

			return response.getBody();
		} catch (Exception e) {
			logger.error("Error while getting user profile: ", e);
			return null;
		}
	}
}