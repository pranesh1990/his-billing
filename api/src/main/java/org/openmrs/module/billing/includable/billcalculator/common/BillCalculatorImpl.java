/**
 *  Copyright 2009 Health Information Systems Project of India
 *
 *  This file is part of Billing module.
 *
 *  Billing module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Billing module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Billing module.  If not, see <http://www.gnu.org/licenses/>.
 *
 **/

package org.openmrs.module.billing.includable.billcalculator.common;

import java.math.BigDecimal;
import java.util.Map;

import org.openmrs.module.billing.includable.billcalculator.BillCalculator;

public class BillCalculatorImpl implements BillCalculator {

	/**
	 * Return 100%
	 */
	public BigDecimal getRate(Map<String, Object> parameters) {
		return new BigDecimal(1);
	}

	public boolean isFreeBill(Map<String, Object> parameters) {

		return false;
	}
}
