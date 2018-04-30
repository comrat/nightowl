{% extends "build.py" %}
{% block plugins %}
	{{ super() }}
        os.system('cordova plugin add cordova-plugin-websocket-server')
{% endblock %}
