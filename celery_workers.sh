#!/bin/bash

celery worker -l DEBUG -Q boardbooks >> boardbooks.log
celery worker -l DEBUG -Q documents >> documents.log
celery worker -l DEBUG -Q notifications >> notifications.log
celery worker -l DEBUG -Q thumbnails >> thumbnails.log
celery worker -l DEBUG -Q validations >> validations.log
