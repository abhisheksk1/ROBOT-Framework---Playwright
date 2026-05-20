import os
import shutil
from robot import run

REPORT_DIR = "reports"

# Delete old reports
if os.path.exists(REPORT_DIR):
    shutil.rmtree(REPORT_DIR)

os.makedirs(REPORT_DIR)

# Execute tests
run(
    "tests/test2.robot",
    outputdir=REPORT_DIR,
    output="output.xml",
    log="log.html",
    report="report.html"
)