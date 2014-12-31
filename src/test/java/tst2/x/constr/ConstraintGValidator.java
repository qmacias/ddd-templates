/**
 * Copyright (C) 2015 Michael Schnell. All rights
 * reserved. <http://www.fuin.org/>
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option) any
 * later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library. If not, see <http://www.gnu.org/licenses/>.
 */
package tst2.x.constr;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/** Constraint G - External type target - With exception - No variables */
// CHECKSTYLE:OFF:LineLength
public final class ConstraintGValidator implements ConstraintValidator<ConstraintG, String> {
	// CHECKSTYLE:ON:LineLength

	@Override
	public final void initialize(final ConstraintG annotation) {
		// TODO Implement!
	}

	@Override
	public final boolean isValid(final String object, final ConstraintValidatorContext ctx) {
		// TODO Implement!
		return true;
	}

	/**
	 * Verifies that the argument is valid an throws an exception otherwise.
	 * 
	 * @param obj Object to validate.
	 * 
	 * @throws GException The constraint was violated.
	 */
	public static void requireValid(final String obj) throws GException {
		// TODO Implement!
		// if ( ... ) {
		//		throw new GException();
		// }
	}

}
