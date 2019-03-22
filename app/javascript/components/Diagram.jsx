import React from 'react';
import { ArcherContainer, ArcherElement } from 'react-archer';

const rowStyle = {
  margin: '200px 0',
  display: 'flex',
  justifyContent: 'space-between',
};
const boxStyle = { padding: '10px', border: '1px solid black', textAlign: 'center' };

const generateCondition = (conditions) => {
  let relations = [];

  conditions.map((condition) => {
    relations.push(
        {
          targetId: condition.first_conditionable.node_id,
          targetAnchor: 'bottom',
          sourceAnchor: 'top',
        }
      );
      if (condition.second_conditionable_id !== null) {
        relations.push(
          {
            targetId: condition.second_conditionable.node_id,
            targetAnchor: 'bottom',
            sourceAnchor: 'top',
          }
        );
      }
    }
  );

  return relations;
};

const generateNode = (relation) => {
  return (
    <ArcherElement
      key={relation.node_id}
      id={relation.node_id}
      relations={relation.conditions.length > 0 ? generateCondition(relation.conditions) : ''}
    >
      <div style={boxStyle}>
        {relation.node_id}<br/>
        {relation.node.label_translations['en']}<br/>
        {relation.node.reference}
        <hr/>
        {relation.node.answers.map((answer) => (answer.reference))}
      </div>
    </ArcherElement>
  )
};

class Diagram extends React.Component {
  render = () => {

    const {
      diagnostic,
      finalDiagnostics,
      treatments,
      managements,
    } = this.props;

    return (
      <div style={{ height: '800px', margin: '50px' }}>
        <ArcherContainer strokeColor="red">
          {diagnostic.map((levels) => (
            <div style={rowStyle}>
              {levels.map((relation) => (generateNode(relation)))}
            </div>
          ))}
          <div>
            {finalDiagnostics.reduce((r, { instances }) => {
              let and_condition = instances[0].conditions.map(condition => condition.operator === 'and_operator');
              if (and_condition.includes(true)) {

              }
            }, [])}
            {finalDiagnostics.map((finalDiagnostic) => (
              <div>
                <ArcherElement
                  key={finalDiagnostic.instances[0].id}
                  id={finalDiagnostic.instances[0].node_id}
                  relations={generateCondition(finalDiagnostic.instances[0].conditions)}
                >
                  <div style={boxStyle}>
                    {finalDiagnostic.id}<br/>
                    {finalDiagnostic.label_translations['en']}<br/>
                    {finalDiagnostic.reference}
                    <hr/>
                    {treatments.map(treatment => treatment.reference + ' ')}
                    {managements.map(management => management.reference + ' ')}
                  </div>
                </ArcherElement>
              </div>))}
          </div>
        </ArcherContainer>
      </div>
    );
  };
}

export default Diagram;
