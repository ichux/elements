import multiprocessing
import os
import pathlib

from dotenv import load_dotenv

load_dotenv()


def strtobool(val):
    """Convert a string representation of truth to true (1) or false (0).
    True values are 'y', 'yes', 't', 'true', 'on', and '1'; false values
    are 'n', 'no', 'f', 'false', 'off', and '0'.  Raises ValueError if
    'val' is anything else. And return False on AttributeError.
    """
    try:
        val = val.lower()
    except AttributeError:
        return 0

    if val in ("y", "yes", "t", "true", "on", "1"):
        return 1
    if val in ("n", "no", "f", "false", "off", "0"):
        return 0

    raise ValueError(f"invalid truth value {val}")


wsgi_app = "core.wsgi:application"
bind = "0.0.0.0:8000"

accesslog = f'{pathlib.Path.cwd() / "ancillaries" / "logs" / "gunicorn-access.log"}'
errorlog = f'{pathlib.Path.cwd() / "ancillaries" / "logs" / "gunicorn-error.log"}'
capture_output = True
loglevel = "debug"
access_log_format = (
    "%(h)s %(l)s %(u)s %(t)s '%(r)s' %(s)s %(b)s '%(f)s' '%(a)s' in %(D)sµs"
)
max_requests = 10000
max_requests_jitter = 1000
timeout = 30
graceful_timeout = 30

workers = int(os.getenv("CONCURRENCY", multiprocessing.cpu_count() * 2 + 1))
reload = bool(strtobool(os.getenv("WEB_RELOAD", "false")))
# worker_class = "meinheld.gmeinheld.MeinheldWorker"

pidfile = f'{pathlib.Path.cwd() / "ancillaries" / "logs" / "ws.pid"}'
profiling_prefix = f'{pathlib.Path.cwd() / "ancillaries" / "logs" / "cprof."}'


def post_fork(server, worker):
    """
    Execute code just after a worker has been forked.
    The callable needs to accept two instance variables for
    the Arbiter and new Worker.
    """

    if bool(strtobool(os.getenv("PROFILE"))):
        import cProfile

        orig_init_process_ = worker.init_process

        def profiling_init_process(self):
            orig_init_process = orig_init_process_
            cProfile.runctx(
                "orig_init_process()",
                globals(),
                locals(),
                f"{profiling_prefix}{os.getpid()}",
            )

        worker.init_process = profiling_init_process.__get__(worker)
