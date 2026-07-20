# Official Python runtime image
FROM python:3.12-slim 
 
WORKDIR /dbt

# copy over python dependencies file
COPY requirements.txt .

# install python dependencies - this layer is cached unless requirements.txt changes
RUN pip install --no-cache-dir -r requirements.txt

# copy the dbt project files AFTER installing requirements to leverage cache
COPY dbt/ .

RUN chmod +x run_dbt.sh

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["./run_dbt.sh"]
