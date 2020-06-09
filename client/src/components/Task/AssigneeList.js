import React from 'react';
import { Grid } from '@material-ui/core';
import AssignmentIndIcon from '@material-ui/icons/AssignmentInd';
import AssigneeChip from './AssigneeChip';
import AddAssigneeIcon from './AddAssigneeIcon';

function AssigneeList({ taskId, assignees, canManage }) {
  return (
    <Grid container spacing={1} alignItems="center">
      <Grid item>
        <AssignmentIndIcon color="action" style={{ verticalAlign: 'middle' }} />
      </Grid>
      {assignees.map((assignee) => (
        <Grid item key={assignee.id}>
          <AssigneeChip
            taskId={taskId}
            assignee={assignee}
            canManage={canManage}
          />
        </Grid>
      ))}
      {canManage && (
        <Grid item>
          <AddAssigneeIcon taskId={taskId} />
        </Grid>
      )}
    </Grid>
  );
}

export default AssigneeList;
