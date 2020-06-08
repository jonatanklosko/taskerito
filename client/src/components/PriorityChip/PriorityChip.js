import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import { Chip } from '@material-ui/core';
import { getPriorityData } from '../../lib/priorities';
import { red, yellow, blue, brown } from '@material-ui/core/colors';

const useStyles = makeStyles((theme) => ({
  priority1: {
    backgroundColor: red[500],
    color: theme.palette.getContrastText(red[500]),
    fontWeight: 500,
  },
  priority2: {
    backgroundColor: yellow[500],
    color: theme.palette.getContrastText(yellow[500]),
    fontWeight: 500,
  },
  priority3: {
    backgroundColor: blue[500],
    color: theme.palette.getContrastText(blue[500]),
    fontWeight: 500,
  },
  priority4: {
    backgroundColor: brown[500],
    color: theme.palette.getContrastText(brown[500]),
    fontWeight: 500,
  },
}));

function PriorityChip({ priority }) {
  const classes = useStyles();
  const { label } = getPriorityData(priority);

  return (
    <Chip
      size="small"
      label={label}
      className={classes['priority' + priority]}
    />
  );
}

export default PriorityChip;
