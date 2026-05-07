FROM pingidentity/pingfederate:latest

EXPOSE 9031 9999

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
  CMD curl -sk https://localhost:9999/pingfederate/app || exit 1
