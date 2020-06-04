from fastapi import FastAPI

app = FastAPI(
    openapi_url='/api/openapi.json',
    docs_url='/api/docs',
    redoc_url='/api/redoc'
)


@app.post('/api/auth')
async def root():
    return {'Status': 'Foobar'}
