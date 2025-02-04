from setuptools import find_packages, setup


setup(
    # other arguments...
    packages=find_packages(where="src", include=["app*", "models*"]),
)
