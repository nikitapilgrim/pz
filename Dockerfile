# Thin layer over the community image: our start/init/backup scripts and config templates are baked in,
# so the host needs nothing but Docker (Windows, macOS or Linux).
FROM sknnr/zomboid-dedicated-server:v1.1.1

USER root
COPY scripts/ /pz/scripts/
COPY config/ /pz/config/
# Strip Windows line endings (a checkout on Windows may add them) and install the fixed config editor.
RUN find /pz -type f -exec sed -i 's/\r$//' {} + \
 && chmod 755 /pz/scripts/* \
 && install -o steam -g steam -m 755 /pz/scripts/config_editor.py /home/steam/config_editor.py \
 && command -v runuser >/dev/null

USER steam
CMD ["bash", "/pz/scripts/server.sh"]
