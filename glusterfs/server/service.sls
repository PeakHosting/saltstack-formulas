{% from "glusterfs/map.jinja" import server with context %}

{%- if server.enabled %}

glusterfs_packages:
  pkg.installed:
    - names: {{ server.pkgs }}

glusterfs_service:
  service.running:
    - name: {{ server.service }}
    - require:
      - pkg: glusterfs_packages

{%- if server.volumes is defined %}
{%- for name, volume in server.volumes.iteritems() %}

{{ volume.storage }}:
  file.directory:
    - makedirs: true

{%- endfor %}
{%- endif %}

{%- endif %}
