import re

with open('README.md', 'r') as f:
    text = f.read()

# Replace the ugly table for repository structure with a clean code block
old_table = r'''\|  \|
\| --- \|
\| \. ├── monitoring/ │   ├── log\\_analytics\\_queries\.sql    # Egress and latency tracking │   └── dashboard\\_filters\.txt        # Cloud Logging filters ├── terraform/ │   ├── main\.tf                      # CDN and Origin resources │   ├── variables\.tf                 # Project-specific variables │   └── outputs\.tf                   # Target IPs and bucket names └── docs/     └── troubleshooting\\_matrix\.md    # Cache header reference \|'''

new_structure = '''```text
. 
├── monitoring/ 
│   ├── log_analytics_queries.sql    # Egress and latency tracking 
│   └── dashboard_filters.txt        # Cloud Logging filters 
├── terraform/ 
│   ├── main.tf                      # CDN and Origin resources 
│   ├── variables.tf                 # Project-specific variables 
│   └── outputs.tf                   # Target IPs and bucket names 
└── docs/    
    └── troubleshooting_matrix.md    # Cache header reference
```'''

text = re.sub(old_table, new_structure, text)

with open('README.md', 'w') as f:
    f.write(text)

