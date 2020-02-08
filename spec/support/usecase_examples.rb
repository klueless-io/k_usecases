module UsecaseExamples
  def create_example_group
    double("RootExampleGroup",
      descendants: decendant_children,
      metadata: documentor_settings
    )
  end

  def create_descendant_parents
    double(parent_groups: [
        double(description: 'Default Title'),
        double(description: 'C'),
        double(description: 'B'),
        double(description: 'A'),
      ])
  end

  def create_describe
    double("ExampleGroup",
      metadata: {},
      example_group: descendant_parents,
      descendants: []) 
  end

  def create_usecase1
    double("ExampleGroupUsecase",
      metadata: { usecase: true },
      name: 'usecase1',
      example_group: descendant_parents,
      descendants: [],
      examples: [])
  end
  
  def create_usecase2
    double("ExampleGroupUsecase",
      metadata: { 
        usecase: true,
        usage: 'MyClass.load',
        title: 'My custom title'
      },
      name: 'usecase2',
      example_group: descendant_parents,
      descendants: [],
      examples: [
        double('Example', description: 'Expected outcome 1', metadata: {}),
        double('Example', description: 'Expected outcome 2', metadata: {})
      ]) 
  end

  def create_usecase3
    double("ExampleGroupUsecase",
      metadata: { 
        usecase: true,
        usage: 'MyClass.load',
        title: 'My custom title with content examples',
        content: [content1, content2]
      },
      name: 'usecase3',
      example_group: descendant_parents,
      descendants: [],
      examples: [
        double('Example', description: 'Expected outcome A', metadata: {}),
        double('Example', description: 'Expected outcome B', metadata: {})
      ]) 
  end

  def create_content1
    { title: 'title 1', description: 'description 1', type: :code, code_type: :ruby}
  end
  def create_content2
    { title: 'title 2', description: 'description 2'}
  end
  
end