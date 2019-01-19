json.extract! @task,  :id,:title, :status
json.status_class @task.status == 0 ? 'closed-task' : ''
json.path plan_list_task_path(@plan, @list, @task)