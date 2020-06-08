import React from 'react';
import { Link as RouterLink } from 'react-router-dom';
import {
  List,
  ListItem,
  ListItemText,
  Grid,
  Paper,
  Typography,
  ListItemSecondaryAction,
} from '@material-ui/core';
import noDataImage from './no-data.svg';
import { formatDatePart } from '../../lib/date';
import PriorityChip from '../PriorityChip/PriorityChip';

function TaskList({ label, tasks }) {
  return (
    <Grid container direction="column" spacing={1}>
      <Grid item>
        <Typography variant="h6">{label}</Typography>
      </Grid>
      <Grid item>
        {tasks.length === 0 ? (
          <img src={noDataImage} alt="No tasks in this section." height="128" />
        ) : (
          <Paper>
            <List>
              {tasks.map((task) => (
                <ListItem
                  key={task.id}
                  button
                  component={RouterLink}
                  to={`/tasks/${task.id}`}
                >
                  <ListItemText
                    primary={task.name}
                    secondary={
                      task.finishedAt
                        ? `Finished on ${formatDatePart(task.finishedAt)}`
                        : `Created on ${formatDatePart(task.insertedAt)}`
                    }
                  />
                  <ListItemSecondaryAction>
                    {' '}
                    <PriorityChip priority={task.priority} />
                  </ListItemSecondaryAction>
                </ListItem>
              ))}
            </List>
          </Paper>
        )}
      </Grid>
    </Grid>
  );
}

export default TaskList;
