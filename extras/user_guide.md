# Manual dashboard rebuildig

The following error can be raised during importing the dashboard `.zip` file (full text error is in [dashborad_import_error.txt](dashborad_import_error.txt)) file.

``` bash
superset.commands.exceptions.CommandInvalidError: Error importing dashboard
```

You can rebuild the dashboard manually.

1. Connect to database. Navigate to "Settings", select "Database connection". Press "+ DATABASE" button, click "PostgreSQL". Scroll down and choose "Connect this database with SQLAlchemy URL string instead" line. In "SQLAlchemy URI*" field paste the following string "postgresql://postgres:qwerty@172.17.0.1:5438/demo". Then go to "ADVANCED" settings, unwrap "SQL Lab" section and select "Allow DML". (For more details see [installation using docker](https://superset.apache.org/docs/installation/installing-superset-using-docker-compose/)).
2. Create datasets. Navigate to "SQL", select "SQL Lab". Use SQL queries in `sql_queries` folder to create datasets. When a query is in code cell, select "Save dataset" in "Save" option. Datasets list should looks like this: <img src="superset_datasets.png">
3. Create charts. This proccess is more complicated. To see all charts configuration, open `charts` folder in dashboard `.zip` file. Eventually you'll get this list of chats: <img src="superset_charts.png">
4. Create dashboard in "Dashboard" tab. Add charts to dashboard. Click "EDIT DASHBOARD", press "..." and then "Edit CSS". Insert the [css_style.css](style.css) code there. Change id of "TABS-WnA5SyA5c8" and "data-test-chart-id" according to html tag in browser code inspection. Check `Air_transportation_1.yaml` file in `dashboards` folder inside the `.zip` archive for correct element layout.
