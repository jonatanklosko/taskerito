import React from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { useQuery, useMutation, gql } from '@apollo/client';
import projectImage from '../ProjectForm/project.svg';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';
import Loading from '../Loading/Loading';
import ProjectForm from '../ProjectForm/ProjectForm';

const PROJECT = gql`
  query Project($id: ID!) {
    project(id: $id) {
      id
      name
      description
    }
  }
`;

const UPDATE_PROJECT = gql`
  mutation UpdateProject($id: ID!, $input: ProjectInput!) {
    updateProject(id: $id, input: $input) {
      successful
      result {
        id
        name
        description
      }
    }
  }
`;

function EditProject() {
  const { id } = useParams();
  const history = useHistory();

  const [updateProject, updateProjectState] = useMutation(UPDATE_PROJECT, {
    onCompleted: ({ updateProject: { successful } }) => {
      if (successful) {
        history.push(`/projects/${id}`);
      }
    },
  });

  const { data, loading, error } = useQuery(PROJECT, { variables: { id } });

  if (error) return 'Something went wrong.';
  if (loading) return <Loading />;
  const { project } = data;

  return (
    <CenteredFormContainer
      svgImage={projectImage}
      title={`Edit - ${project.name}`}
    >
      <ProjectForm
        initialData={project}
        disabled={updateProjectState.loading}
        failed={
          updateProjectState.data &&
          !updateProjectState.data.updateProject.successful
        }
        onSubmit={(data) => updateProject({ variables: { id, input: data } })}
      />
    </CenteredFormContainer>
  );
}

export default EditProject;
