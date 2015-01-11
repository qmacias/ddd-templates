package org.fuin.dsl.ddd.gen.aggregate

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class ESRepositoryFactoryArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreate() {

		// PREPARE
		val aggregateName = "AggregateC"
		val repoClassName = aggregateName + "Repository"
		val className = repoClassName + "Factory"
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.aggregates." + repoClassName, EXAMPLES_CONCRETE + ".x.aggregates." + repoClassName)
		refReg.putReference("XEventRegistry", EXAMPLES_CONCRETE + ".x.resourceset.XEventRegistry")

		val ESRepositoryFactoryArtifactFactory testee = createTestee()
		val Aggregate aggregate = model.find(typeof(Aggregate), aggregateName)

		// TEST
		val result = new String(testee.create(aggregate, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/aggregates/" + className + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new ESRepositoryFactoryArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("esRepositoryFactory",
			ESRepositoryFactoryArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		return parser.parse(Utils.readAsString(class.getResource("/aggregate.ddd")))
	}

}
