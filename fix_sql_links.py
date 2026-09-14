import re

with open('README.md', 'r') as f:
    text = f.read()

# Replace the links pointing to queries/ with monitoring/
text = text.replace('queries/egress_analysis.sql', 'monitoring/egress_analysis.sql')
text = text.replace('queries/cache_execution_analysis.sql', 'monitoring/cache_execution_analysis.sql')

with open('README.md', 'w') as f:
    f.write(text)

