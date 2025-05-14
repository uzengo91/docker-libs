FROM ghcr.io/open-webui/mcpo


RUN apt-get update && apt-get install -y --no-install-recommends \
    telnet \
    net-tools \
    iputils-ping \
    jq \
    && rm -rf /var/lib/apt/lists/*



# Confirm npm and node versions (optional debugging info)
RUN node -v && npm -v


# Verify mcpo installed correctly
RUN which mcpo

# Expose port (optional but common default)
EXPOSE 8000

# Entrypoint set for easy container invocation
ENTRYPOINT ["mcpo"]

# Default help CMD (can override at runtime)
CMD ["--help"]