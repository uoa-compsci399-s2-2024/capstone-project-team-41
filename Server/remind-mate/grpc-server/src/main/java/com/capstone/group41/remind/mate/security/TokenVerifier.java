package com.capstone.group41.remind.mate.security;


import com.auth0.jwk.JwkException;
import com.auth0.jwk.JwkProvider;
import com.auth0.jwk.JwkProviderBuilder;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.RSAKeyProvider;
import org.springframework.stereotype.Service;

import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.concurrent.TimeUnit;

@Service
public class TokenVerifier {
    private static final JwkProvider provider = new JwkProviderBuilder("https://dev-omhf4f5ly70nx3i0.us.auth0.com/")
            .cached(10, 24, TimeUnit.HOURS)
            .build();

    private static final RSAKeyProvider keyProvider = new RSAKeyProvider() {
        @Override
        public RSAPublicKey getPublicKeyById(String kid) {
            try {
                return (RSAPublicKey) provider.get(kid).getPublicKey();
            } catch (JwkException e) {
                throw new RuntimeException(e);
            }
        }
        @Override
        public RSAPrivateKey getPrivateKey() {
            // return the private key used
            return null;
        }
        @Override
        public String getPrivateKeyId() {
            return null;
        }
    };

    private static final Algorithm algorithm = Algorithm.RSA256(keyProvider);
    private static final JWTVerifier verifier = JWT.require(algorithm)
            .withIssuer("https://dev-omhf4f5ly70nx3i0.us.auth0.com/")
            .build();

    public void verifyToken(String token) {
        verifier.verify(token);
    }

}
