# Use the R base image
FROM r-base

# Install system dependencies for shiny
RUN apt-get update && \
    apt-get install -y \
        libssl-dev \
        libcurl4-openssl-dev \
        libxml2-dev

# Install shiny package
RUN R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"

# Set the working directory
WORKDIR /app

# Copy the contents of your app to the image
COPY ./src /app

# Expose port 3838 to the outside world
EXPOSE 3838

# Command to run your shiny app when the container starts
CMD ["R", "-e", "shiny::runApp('/app')"]