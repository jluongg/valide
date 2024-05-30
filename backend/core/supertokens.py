from supertokens_python import init, InputAppInfo, SupertokensConfig


init(
    app_info=InputAppInfo(api_domain="...", app_name="...", website_domain="..."),
    supertokens_config=SupertokensConfig(
        connection_uri="http://localhost:3567", api_key="someKey"
    ),
    framework="fastapi",
    recipe_list=[
        # ...
    ],
)
