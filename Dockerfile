FROM apache/superset:3.0.1

USER root

ENV ADMIN_USERNAME admin
ENV ADMIN_EMAIL admin@superst.com
ENV ADMIN_PASSWORD admin_pas

COPY superset-init.sh superset-init.sh

COPY superset_config.py /app/
ENV SUPERSET_CONFIG_PATH /app/superset_config.py


USER superset

ENTRYPOINT ["sh", "superset-init.sh"]
