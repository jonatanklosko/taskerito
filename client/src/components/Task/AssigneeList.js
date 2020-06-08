import React from 'react';
import { Grid, Chip } from '@material-ui/core';
import AssignmentIndIcon from '@material-ui/icons/AssignmentInd';
import AddIcon from '@material-ui/icons/Add';

function AssigneeList({ assignees }) {
  return (
    <Grid item container spacing={1} alignItems="center">
      <Grid item>
        <AssignmentIndIcon color="action" style={{ verticalAlign: 'middle' }} />
      </Grid>
      {assignees.map((assignee) => (
        <Grid item>
          <Chip
            key={assignee.id}
            size="small"
            label={`@${assignee.username}`}
            variant="outlined"
            color="primary"
          />
        </Grid>
      ))}
      <Grid item>
        <AddIcon color="action" style={{ verticalAlign: 'middle' }} />
      </Grid>
    </Grid>
  );
}

export default AssigneeList;
