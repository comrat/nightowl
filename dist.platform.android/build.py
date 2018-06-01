{% extends "build.py" %}
{% block plugins %}
	{{ super() }}
        os.system('cordova plugins add cordova-plugin-share')
        os.system('cordova plugins add cordova-plugin-clipboard2')
{% endblock %}
