import React from 'react';
import { Grid } from '@material-ui/core';
import TaskList from './TaskList';
import { partition } from '../../lib/utils';

function TasksBoard({ tasks }) {
  const [finished, nonFinished] = partition(tasks, (task) => task.finishedAt);
  const [assigned, awaiting] = partition(
    nonFinished,
    (task) => task.assignees.length > 0
  );

  return (
    <Grid container spacing={4}>
      <Grid item xs={12} md>
        <TaskList label="Awaiting" tasks={awaiting} />
      </Grid>
      <Grid item xs={12} md>
        <TaskList label="Assigned" tasks={assigned} />
      </Grid>
      <Grid item xs={12} md>
        <TaskList label="Finished 🎉" tasks={finished} />
      </Grid>
    </Grid>
  );
}

export default TasksBoard;
