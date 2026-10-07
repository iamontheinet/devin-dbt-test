{% macro interaction_categories() %}
    {{ return(['Billing', 'Refund', 'Technical Issue', 'Account', 'Service Outage', 'Feedback', 'Other']) }}
{% endmacro %}
