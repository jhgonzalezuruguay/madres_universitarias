# Imagen base con R
FROM rocker/shiny:latest

# Instalar paquetes del sistema necesarios
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar paquetes de R
RUN R -e "install.packages(c( \
    'shiny', \
    'shinydashboard', \
    'ggplot2', \
    'dplyr', \
    'plotly' \
    ), repos='https://cloud.r-project.org/')"

# Copiar la app al contenedor
COPY . /srv/shiny-server/

# Permisos
RUN chown -R shiny:shiny /srv/shiny-server

# Puerto que usará Render
EXPOSE 3838

# Ejecutar Shiny Server
CMD ["/usr/bin/shiny-server"]
