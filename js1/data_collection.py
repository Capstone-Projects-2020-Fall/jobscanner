# -*- coding: utf-8 -*-
"""
CHI
"""

import glassdoor_scraper as gs 
import pandas as pd 

path = "/Users/work/js1/chromedriver"

df = gs.get_jobs('engineer',100, False, path, 15)

df.to_csv('jobs.csv', index = False)


df.to_json("gd.json",orient="records")