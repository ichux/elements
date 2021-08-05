import os
import sys

import django
from django.conf import settings
from django.test.utils import get_runner

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "core.settings")


if __name__ == "__main__":
    django.setup(set_prefix=False)
    TestRunner = get_runner(settings)
    test_runner = TestRunner()
    failures = test_runner.run_tests(["api"])
    sys.exit(bool(failures))
