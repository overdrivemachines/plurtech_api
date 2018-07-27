#!/bin/bash

rails db:drop
rails db:migrate
rails c