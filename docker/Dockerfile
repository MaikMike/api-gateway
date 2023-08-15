FROM devopsfaith/krakend as builder

ARG ENVIRONMENT=dev
RUN echo Building $ENVIRONMENT environment

COPY ./src/krakend.json /etc/krakend/krakend.json
COPY ./src/templates/ /etc/krakend/templates/
COPY ./src/partials /etc/krakend/partials/
COPY ./src/${ENVIRONMENT}/settings /etc/krakend/settings/

COPY ./docker/docker-entrypoint.sh /etc/docker-entrypoint.sh

# The linting needs the final krakend.json file
# The build will fail if KrakenD linter rules do not pass
RUN \
	FC_ENABLE=1 \
	FC_SETTINGS="/etc/krakend/settings" \
	FC_TEMPLATES="/etc/krakend/templates" \
	FC_PARTIALS="/etc/krakend/partials" \
	# FC_OUT=out.json \
	krakend check -t -d -c /etc/krakend/krakend.json


FROM --platform=linux/amd64 devopsfaith/krakend:2.3.2
COPY --from=builder /etc/krakend/ .
COPY ./docker/docker-entrypoint.sh /etc/docker-entrypoint.sh

EXPOSE 8080 8090 9091

ENTRYPOINT []

CMD ["sh", "/etc/docker-entrypoint.sh"]