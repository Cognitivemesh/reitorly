# Reitorly

This application showcases how to combine LLMs, semantic data modeling to effortlessly craft intricate business logic queries.

It combines the following technologies: 
  * [Malloy](https://github.com/malloydata/malloy) which is a modern open source language for analyzing, transforming, and modeling data.
Malloy queries are seamlessly translate into SQL, optimized for your database.
  * [Duckdb](https://duckdb.org/) is an OLAP runtime 
  * [Gorilla](https://github.com/ShishirPatil/gorilla) is a runtime for LLM-generated actions like code, API calls, and more. [Gorilla execution](https://gorilla.cs.berkeley.edu/) is an advanced Large Language Model (LLM) designed to effectively interact with a wide range of APIs, enhancing the capabilities of LLMs in real-world applications. The [Gorilla Open functions](https://huggingface.co/gorilla-llm/gorilla-openfunctions-v2) is explained in the following [document](https://konghq.com/blog/engineering/gorilla-llm).
  * [Marimo](https://marimo.io/) is an open-source reactive notebook for Python. It is reproducible, git-friendly, executable as a script, and shareable as an app.
  * [Polars](https://duckdb.org/docs/guides/python/polars.html) is a python library (integrated at Rust) with supports [Arrow](https://arrow.apache.org/docs/python/index.html) and it is compatible.
  * [UV Package Manager]() is a package manager.

## Dockerfile
* Create a docker container with Malloy, [Polars](https://duckdb.org/docs/guides/python/polars.html), DuckDB, and [Marimo](https://marimo.io/) , using uv package manager.

## pyproject.toml
This is a file from uv package manager which loads the following libraries:
  * Malloy
  * Polars
  * DuckDB
  * Gorilla
  * Marimo

```python
pip install -U duckdb 'polars[pyarrow]'
```
