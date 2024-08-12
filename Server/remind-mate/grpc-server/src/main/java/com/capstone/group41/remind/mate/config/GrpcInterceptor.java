package com.capstone.group41.remind.mate.config;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.capstone.group41.remind.mate.security.TokenVerifier;
import io.grpc.*;
import lombok.extern.slf4j.Slf4j;
import net.devh.boot.grpc.server.interceptor.GrpcGlobalServerInterceptor;

import static com.capstone.group41.remind.mate.config.ConstantProvider.AUTHORIZATION_HEADER_KEY;

@GrpcGlobalServerInterceptor
public class GrpcInterceptor implements ServerInterceptor {


    public static final Context.Key<Object> AUTHORIZATION = Context.key(AUTHORIZATION_HEADER_KEY);
    private static final TokenVerifier tokenVerifier = new TokenVerifier();

    @Override
    public <ReqT, RespT> io.grpc.ServerCall.Listener<ReqT> interceptCall(
            io.grpc.ServerCall<ReqT, RespT> call,
            io.grpc.Metadata headers,
            io.grpc.ServerCallHandler<ReqT, RespT> next) {

        Context ctx = Context.current();
        String authorizationToken = headers.get(io.grpc.Metadata.Key.of(AUTHORIZATION_HEADER_KEY, io.grpc.Metadata.ASCII_STRING_MARSHALLER));

        if(authorizationToken == null) {
            call.close(Status.UNAUTHENTICATED.withDescription("Authorization token is missing"), new Metadata());
        }
        try {
            tokenVerifier.verifyToken(authorizationToken);
        } catch (JWTVerificationException exception) {
            call.close(Status.UNAUTHENTICATED.withDescription(exception.getLocalizedMessage()), new Metadata());
        }

        ctx = ctx.withValue(AUTHORIZATION, authorizationToken);

        return Contexts.interceptCall(ctx, call, headers, next);
    }

}
