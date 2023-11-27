ARG MEDCAT_BASE_IMAGE_VERSION=0.5.1
FROM cogstacksystems/medcat-service:$MEDCAT_BASE_IMAGE_VERSION

ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

# Additional settings

# IMPORTANT : log level set 
# CRITICAL - 50, ERROR - 40, WARNING - 30, INFO - 20, DEBUG - 10, NOTSET - 0
ENV APP_LOG_LEVEL=ERROR

# can include only one model for NER
ENV APP_NAME=MedCAT
ENV APP_MODEL_LANGUAGE=en
ENV APP_MODEL_NAME=MedMen
ENV APP_MODEL_CDB_PATH=/cat/models/cdb.dat
ENV APP_MODEL_VOCAB_PATH=/cat/models/vocab.dat

# optionally, can include multiple models for meta tasks, separated using ':'
ENV APP_MODEL_META_PATH_LIST=/cat/models/Status

# NLP processing
ENV APP_BULK_NPROC=16
ENV APP_TRAINING_MODE=False

ENV TYPE=NOT_UMLS

# IMPORTANT : log level set 
# CRITICAL - 50, ERROR - 40, WARNING - 30, INFO - 20, DEBUG - 10, NOTSET - 0
ENV LOG_LEVEL=40

ENV NESTED_ENTITIES=False
ENV APP_CUDA_DEVICE_COUNT=0
ENV CNTX_SPAN=9
ENV CNTX_SPAN_SHORT=3
ENV MIN_CUI_COUNT=30000
ENV MIN_CUI_COUNT_STRICT=-1
ENV MIN_ACC=0.2
ENV MIN_ACC_TH=0.2

ENV LEARNING_RATE=0.1
ENV ANNEAL=False
ENV KEEP_PUNCT=:|.

# IMPORTANT:
#   Mode in which annotation entities should be outputted in the JSON response,
#   by default this is set to "list" of dicts, so the output would be : {"annotations": [{"id": "0", "cui" : "C1X..", ..}, {"id":"1", "cui": "...."}]}
#   newer versions of MedCAT (1.2+) output entities as a dict, where the id of the entity is a key and the rest of the data is a value, so for "dict",
#   the output is
#    {"annotations": {"entities": {"0": {"cui": "C0027361", "id": 0,.....}, "1": {"cui": "C001111", "id": 1......}}
#   Be mindful of this option as it can affect other services that rely directly on the responses of the service 
#    (the NiFi groovy scripts and annotation ingester are two such services that process the output, and so they might require further customisation)
# POSSIBLE VALUES: [list, dict], if left empty then "dict" is the default.
ENV ANNOTATIONS_ENTITY_OUTPUT_MODE=dict

# Copy the remaining files
COPY ./models /cat/models/
