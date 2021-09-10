FROM alpine:latest AS builder
RUN apk --update add --no-cache stoken

ARG RSA_TOKEN
ENV XT_RSA_TOKEN=$RSA_TOKEN

ARG RSA_PIN
ENV XT_RSA_PIN=$RSA_PIN

RUN stoken import --token "${XT_RSA_TOKEN}" --new-password=""
RUN stoken setpin --new-pin="${XT_RSA_PIN}"

FROM alpine:latest
RUN apk --update add --no-cache stoken
COPY --from=builder /root/.stokenrc /root/

#ENTRYPOINT ["stoken"]
#CMD ["tokencode"]

