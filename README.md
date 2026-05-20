# Robot Playwright Automation

This repository contains Robot Framework automation tests using the Browser library (Playwright).

## Project Structure

- `requirements.txt` - Python dependencies for Robot Framework and Browser integration.
- `run_test.py` - Convenience script that clears the `reports/` directory and runs `tests/test2.robot`.
- `tests/` - Robot test cases.
  - `test1.robot` - Mystery book scraping task for `books.toscrape.com`.
  - `test2.robot` - DemoQA form automation task, driven by CSV test data.
- `resources/` - Supporting files such as downloaded assets and CSV test data.
- `reports/` - Generated Robot Framework report output.
- `browser/`, `results/` - Additional report and artifact directories.

## Requirements

Install the Python dependencies listed in `requirements.txt`:

```bash
python -m pip install -r requirements.txt
```

## Running Tests

### Run the demo form test (`test2.robot`)

```bash
python run_test.py
```

### Run a specific Robot test directly

```bash
python -m robot.run --dryrun tests/test2.robot
```

or

```bash
python -m robot.run --dryrun tests/test1.robot
```

### Run the full test case

```bash
python -m robot.run tests/test2.robot
```

## Notes

- `test1.robot` scrapes mystery books and saves results to `mystery_books.csv`.
- `test2.robot` reads test data from `resources/test_data.csv` and automates the DemoQA practice form.
- The current `run_test.py` script is configured to execute `tests/test2.robot`.

## Troubleshooting

- If a library import fails, ensure the packages in `requirements.txt` are installed into your active Python environment.
- Use `--dryrun` to validate test syntax before full execution.
