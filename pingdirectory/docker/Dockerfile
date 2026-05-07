FROM pingidentity/pingdirectory:latest

EXPOSE 389 636 443 8989

HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=5 \
  CMD /opt/out/instance/bin/ldapsearch \
    --hostname localhost \
    --port 389 \
    --baseDN "" \
    --searchScope base \
    "(objectclass=*)" 1.1 || exit 1
