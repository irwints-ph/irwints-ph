## How To Get Approvers
1	Select Workflow Type from RULTB
2	Get Elemets Selection from ELMTB
3	Supply Value from Document: Need mapping of definition from ELMTB to DB Fields of transaction
4	Loop at PFACT for each element of type PF from document to get responsibility - Responsibility Rule
5	Loop at CL24N table of type CL to get release strategy/release group
6	Input value from #5 to PFACT to get resposibility (RSPNM). 
7	Get position of responsibility from table OMRSP
  Get number of approvers from T16FS from #5
  Get Release strategy from

```mermaid
flowchart LR
  I[/WF-ID,Current Step/] --> 
  P[[<a href='#how-to-get-approvers'>Get Approvers</a>]] --> 
  O[/Next Appprover details/]
  click O "https://mermaid.js.org/syntax/flowchart.html#multi-directional-arrows"
  click I "https://mermaid.js.org/syntax/flowchart.html#styling-a-node"

```
## TODO
- [ ] Create function for getting approvers

## Mermaid Samples
### Mermaid 11 samples
- This is not supported currently in github
```mermaid
zenuml
    title Annotators
    @Actor Alice
    @Database Bob
    Alice->Bob: Hi Bob
    Bob->Alice: Hi Alice
```

- This is supported
```mermaid
flowchart RL
    A@{ shape: manual-file, label: "File Handling"}
    B@{ shape: manual-input, label: "User Input"}
    C@{ shape: docs, label: "Multiple Documents"}
    D@{ shape: procs, label: "Process Automation"}
    E@{ shape: paper-tape, label: "Paper Records"}
```
```mermaid
flowchart TD
    A([Start]) --> B[Enter Username]
    B --> C[Enter Password]
    C --> D{Is the username and password correct?}
    D -->|Yes| E[Grant Access]
    D -->|No| F[Show error message, retry]
    E --> G([End])
    F --> B
```    


```mermaid
flowchart LR
    A[[Create Document Process]] --> 
    B[[Division Approval]]
    B --> C[[Finance Approval]]
    C --> D[[SAP Posting]]
    click A "#create-document-process" "Jump to create doc"
    click B "https://www.github.com" "link"
    click C "#finance-approval" "Jump to Section"

```

```mermaid
flowchart LR
    A[[<a href='#create-document-process'>Create Document Process</a>]] --> B[[<a href='#division-approval'>Division Approval<a>]]
    B --> C[[<a href='#finance-approval'>Finance Approval<a>]]
    C --> D[[SAP Posting]]
```

<body>
  <pre class="mermaid">
    flowchart LR
        A-->B
        B-->C
        C-->D
        click A callback "Tooltip"
        click B "https://www.github.com" "This is a link"
        click C call callback() "Tooltip"
        click D href "https://www.github.com" "This is a link"
  </pre>

  <script>
    window.callback = function () {
      alert('A callback was triggered');
    };
    const config = {
      startOnLoad: true,
      flowchart: { useMaxWidth: true, htmlLabels: true, curve: 'cardinal' },
      securityLevel: 'loose',
    };
    mermaid.initialize(config);
  </script>
</body>
